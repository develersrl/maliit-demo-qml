#ifndef WORDRIBBONITEM_H
#define WORDRIBBONITEM_H

#include <mstylablewidget.h>
#include "wordribbonitemstyle.h"
#include "wordribbon.h"

/*!
 * \brief WordRibbonItem is used to display pictogram in a candidate list
 *
 */
class WordRibbonItem : public MStylableWidget
{
    Q_OBJECT
    M_STYLABLE_WIDGET(WordRibbonItemStyle)

    enum ItemState { 
        NormalState, 
        SelectedState, 
        PressState
    };

public:
    WordRibbonItem(WordRibbon::ItemStyleMode mode, MWidget* parent = 0);

    virtual ~WordRibbonItem();

    //! reimp
    virtual void drawBackground(QPainter *painter, const QStyleOptionGraphicsItem *option) const;
    virtual void drawContents(QPainter *painter, const QStyleOptionGraphicsItem *option) const;
    virtual QSizeF sizeHint(Qt::SizeHint which, const QSizeF & constraint = QSizeF()) const;

    virtual void mousePressEvent(QGraphicsSceneMouseEvent * event);
    virtual void mouseReleaseEvent(QGraphicsSceneMouseEvent * event);
    virtual void mouseMoveEvent(QGraphicsSceneMouseEvent * event);
    virtual void cancelEvent(MCancelEvent *event);
    virtual void applyStyle();
    //! reimp_end

    /*!
     * \brief Sets maximum width of the widget
     */
    void setMaxWidth(int width);

    /*!
     * \brief Sets the label of the widget
     */
    virtual void setText(const QString& str);

    /*!
     * \brief Returns the label of the widget
     */
    virtual QString text();

    /*!
     * \brief Clears the label
     */
    virtual void clearText();

    /*!
     * \brief Sets item to be highlightable
     *
     * By default the item is highlightable
     */
    virtual void enableHighlight();

    /*!
     * \brief Sets item to be not highlightable
     */
    virtual void disableHighlight();

    /*!
     * \brief Sets the item to be highlighted
     */
    virtual void highlight();

    /*!
     * \brief Clears the highlight
     */
    virtual void clearHighlight();

    /*!
     * \brief Returns whether the item is highlighted
     */
    virtual bool highlighted() const;

    /*!
     * \brief Sets the position index of the item in the list
     *
     * The number shows it's position inside the list.
     * This information is used by the input method engine
     * to improve the prediction/correction.
     */
    virtual void setPositionIndex(int index);

    /*!
     * \brief Returns the position index of the item in the list
     *
     * \sa setPositionIndex
     */
    virtual int positionIndex() const;

signals:
    void mousePressed();
    void mouseReleased();

private:
    QRect contentRect;
    QRect paddingRect;
    QString label;
    QSize minimumSize;
    QSize preferredSize;
    int mPositionIndex;

    bool isMousePressCancelled;
    bool highlightEffectEnabled;

    virtual void recalculateItemSize();
    QFont drawFont;

    int forceMaxWidth;

    void updateStyleState(ItemState newState);

    ItemState state;
    QPen textPen;

    WordRibbon::ItemStyleMode mode;

    friend class Ut_WordRibbonItem;
};

#endif // WORDRIBBONITEM_H